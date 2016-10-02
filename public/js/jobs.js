function initMap() {
    var maxMonthlyRent = $('#max-monthly-rent').change(loadResults);

    var startLatLng = {
        lat: 37,
        lng: -97
    };

    var map = new google.maps.Map($('#map')[0], {
        zoom: 4,
        center: startLatLng
    });

    var geocoder = new google.maps.Geocoder();
    var markers = [];
    var clusterMarker = new MarkerClusterer(map, null, {
        imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
    });

    function getLocation(address) {
        var deferred = new $.Deferred();

        geocoder.geocode({
            address: address
        }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                deferred.resolve(results[0].geometry);
            } else {
                deferred.reject();
            }
        });

        return deferred.promise();
    }

    function createMarker(listing) {
        var marker = new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(listing.lat, listing.lng),
            title: listing.businessaddress
        });
        var infoWindow = new google.maps.InfoWindow({
            content: listing.businessname +
                '<br/><br/><a href="/jobs/' + listing.jobs_listing_id +
                '">View more details...</a>'
        })
        marker.addListener('click', function() {
            infoWindow.open(map, marker);
        })
        markers.push(marker);
    }

    function loadResults() {
        clusterMarker.clearMarkers();
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];

        return $.get('/jobs-list')
            .then(function(data) {
                data.forEach(createMarker);

                clusterMarker.addMarkers(markers);
            })
            .fail(function(err) {
                alert('Unables to load listings');
            });
    }

    loadResults();

    $('#location').change(function(e) {
        getLocation($(this).val())
            .then(function(geometry) {
                map.setCenter(geometry.location);
                map.fitBounds(geometry.viewport);
            });
    });
}
