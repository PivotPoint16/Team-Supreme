function initMap() {
    var maxMonthlyRent = $('#max-monthly-rent').change(loadResults);
    var startDate = $('#start-date').change(loadResults);
    var endDate = $('#end-date').change(loadResults);

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
            position: new google.maps.LatLng(listing.apartment_latitude, listing.apartment_longitude),
            title: listing.apartment_listing_address
        });
        var infoWindow = new google.maps.InfoWindow({
            content: listing.apartment_listing_address +
                '<br/>Monthly Rent: $' +
                listing.user_apartment_info_rent + '<br/><br/>' +
                '<a href="/housing/' + listing.user_apartment_info_id +
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

        return $.get('/housing-list')
            .then(function(data) {
                data.filter(function(d) {
                    var maxMonthlyRentVal = maxMonthlyRent.val();
                    return maxMonthlyRentVal === '' ? true :
                        parseInt(maxMonthlyRentVal) >= d.user_apartment_info_rent
                }).filter(function(d) {
                    var startDateVal = startDate.val();
                    return startDateVal ?
                        new Date(startDateVal) >= new Date(d.user_apartment_info_start_date)
                        : true
                }).filter(function(d) {
                    var endDateVal = endDate.val();
                    return endDateVal ?
                        new Date(endDateVal) <= new Date(d.user_apartment_info_end_date)
                        : true
                }).forEach(createMarker);

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
