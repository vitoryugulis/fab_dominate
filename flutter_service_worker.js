'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/fonts/MaterialIcons-Regular.otf": "9393039c989cfca89bf6dcae6ecd943f",
"assets/AssetManifest.bin.json": "8bf45a62200fadb46860056c3f760d4a",
"assets/AssetManifest.bin": "088f889a190ed4d3b21f00e65a8e48c7",
"assets/AssetManifest.json": "297e9ff6f9bdbfa1cc770dee25898f5f",
"assets/lib/assets/fab.jpg": "56026264821be7929fa22fb8098756c3",
"assets/lib/assets/heroes/slippy_cover.webp": "50c062ff074ded92546e39063a766a22",
"assets/lib/assets/heroes/viserai.jpg": "aae944c02c0d245de31e54a4d652a18f",
"assets/lib/assets/heroes/mst_spoilers.webp": "2eba519c24a42983439b253dbff6f6e3",
"assets/lib/assets/heroes/oscilio_cover.webp": "77d15e6992a5fc26d5934299180b2518",
"assets/lib/assets/heroes/maxx.webp": "bcd487507934e3b573025e3ea88af2b2",
"assets/lib/assets/heroes/aurora_cover.webp": "07fe10a33b11dd52be8b64a4a9719c23",
"assets/lib/assets/heroes/dash.jpg": "ca5c571dc6d4f6fd09d5daa37008d785",
"assets/lib/assets/heroes/riptide.webp": "a6e9d87f961bbe0d4bb55b6b93f6a248",
"assets/lib/assets/heroes/vynnset.webp": "e926dacbd9f950b17e56b9bdfaf75352",
"assets/lib/assets/heroes/boltyn.webp": "d47ffdf6e40edd9da0837a589848e866",
"assets/lib/assets/heroes/victor.webp": "00ab7b7824115bd6ea218b771e2969de",
"assets/lib/assets/heroes/azalea.webp": "0ec5cc186fe374d67fc19397b0c93886",
"assets/lib/assets/heroes/dorinthea.png": "47e76b6e86258e95339549ef954f95d7",
"assets/lib/assets/heroes/rhinar.jpg": "1581be0f02978bc7e1f2c4cfe0da24c2",
"assets/lib/assets/heroes/betsy.webp": "a6630d6f81dcca44d48cecb2728479f8",
"assets/lib/assets/heroes/cindra_cover.webp": "7fc7542e36a78fb09f7f5257a0b52461",
"assets/lib/assets/heroes/kano.png": "dfaa993bd2090c825e44c6416a3dfa7b",
"assets/lib/assets/heroes/kayo.jpeg": "317ac488dd879ee698ecf0005a323db8",
"assets/lib/assets/heroes/olympia.webp": "d5d52be98ab7a6ba8188112c170b4443",
"assets/lib/assets/heroes/jarl_art.jpg": "3bd9fc3de6bedc7f126e4a20ecb4406f",
"assets/lib/assets/heroes/prism.jpg": "7382f9ee30f9495468390effbce2bcc5",
"assets/lib/assets/heroes/kassai.webp": "a88d8357f38f2197e1d0ece48a8437c2",
"assets/lib/assets/heroes/florian_cover.webp": "3a2559ac0de016c3b66cbef7a8c35a12",
"assets/lib/assets/heroes/enigma_wide.webp": "05b7a702a74915897fddbe5e39feed66",
"assets/lib/assets/heroes/levia.webp": "07808c405870493232528e0260553f9b",
"assets/lib/assets/heroes/sea_preview_cover.webp": "1840d857a776e03ce74d144a6641c320",
"assets/lib/assets/heroes/nuu_wide.webp": "c5c0c63e282d085f4fdba566d41d6349",
"assets/lib/assets/heroes/ira.jpg": "f0df8a8dbed8d8d227011645ed39a044",
"assets/lib/assets/heroes/verdance_cover.webp": "5e07cbb3eb1a14cf962b08081bfe1131",
"assets/lib/assets/heroes/fang_story.webp": "06e21817cc5f2ed7ef23c4cf1085798a",
"assets/lib/assets/heroes/chaos_story.webp": "1c4b386519d5cc397ac1bb5587edb094",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "1dabf20e490315410562d8f529cc7a9f",
"main.dart.js": "b4846e079a693cb8f18ea624c3cea3c1",
"manifest.json": "28ccfabdfbd8498cfe99a9b7af81a978",
"version.json": "bfa42ec333cd9463da9a5161559cb568",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"flutter_bootstrap.js": "f13034312c9942926ccef0eac5d0350f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "0c4ade4382db4ead99cbc249b1db152d",
"/": "0c4ade4382db4ead99cbc249b1db152d",
"flutter.js": "4b2350e14c6650ba82871f60906437ea"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
