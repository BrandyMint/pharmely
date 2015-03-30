ymaps.ready(function() {
  var $map = $('#map');
  var yandexMap = new ymaps.Map('map', {
    center: [55.753994, 37.622093],
    zoom: 8,
    controls: ['zoomControl']
  });

  ymaps.geocode($map.data('address'), {
    results: 1
  }).then(function (res) {
    var firstGeoObject = res.geoObjects.get(0),
        coords = firstGeoObject.geometry.getCoordinates(),
        bounds = firstGeoObject.properties.get('boundedBy');

    yandexMap.geoObjects.add(firstGeoObject);
    yandexMap.setBounds(bounds, {
      checkZoomRange: true
    });
  });
});
