'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/LICENSE": "da9af0f4537cc0d4b52849b6216f9306",
"assets/assets/coffee_cup.jpeg": "075cdb788a6e225bffc70027f06fb28d",
"assets/assets/mobilenet.tflite": "5ca18f37b44c50c0e0f93efb2c8b7af2",
"assets/assets/labels.txt": "295d81f0039772b0c909237eb803b42d",
"assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "5310554a11e4c9e5296e7f187578c3ce",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "fd2d21e1eef96db8eca2c5cbbb08d3b6",
"index.html": "358458aff0400b60703fac7b733f9c88",
"/": "358458aff0400b60703fac7b733f9c88",
"manifest.json": "b3bbe336aafd68776364a89610aac54a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
