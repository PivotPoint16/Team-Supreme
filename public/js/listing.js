function initMap() {
    var mapElem = $('#map');

    new google.maps.Map(mapElem[0], {
        zoom: 19,
        center: new google.maps.LatLng(mapElem.attr('lat'), mapElem.attr('long')),
        disableDefaultUI: true,
        mapTypeId: 'hybrid',
    });
}
