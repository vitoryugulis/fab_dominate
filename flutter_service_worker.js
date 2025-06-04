'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.bin": "51317b9d001fc70f08033759491586c5",
"assets/fonts/MaterialIcons-Regular.otf": "9be8f951669147ef48cc15c0dc34af4a",
"assets/AssetManifest.json": "59efe5cd05286d7ce9d282dcdf710e7a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "4479c68e74441b984422c394f6bc59f6",
"assets/lib/assets/high_seas.png": "2553d33c9e99fe7c337c76da01d399fa",
"assets/lib/assets/high_sea_bg.webp": "15a2ff492327d5f8ba89ecb1b5506a12",
"assets/lib/assets/fab.jpg": "56026264821be7929fa22fb8098756c3",
"assets/lib/assets/paper.jpeg": "d5333e083b856ccd2a38211d7d7e3514",
"assets/lib/assets/heroes/boltyn.webp": "d47ffdf6e40edd9da0837a589848e866",
"assets/lib/assets/heroes/young/datadoll.png": "86af59a64312a45e5c95db9e61d995f1",
"assets/lib/assets/heroes/young/levia.png": "b89e7c5a487650d7c7c1ccfda57498c2",
"assets/lib/assets/heroes/young/araknisolitaire.png": "9b781559bb67f902d78962af5abbbc29",
"assets/lib/assets/heroes/young/doridawn.png": "75a9a8c470252a67cd8ee074d9b750b1",
"assets/lib/assets/heroes/young/bravo.png": "b67708a0551a839e3504a5c5aa3ca249",
"assets/lib/assets/heroes/young/shivana.png": "e35bb30708c1092901cc2aee2156c342",
"assets/lib/assets/heroes/young/victor.png": "7715d7109a57c90c270e8524e9ad76e8",
"assets/lib/assets/heroes/young/visserai.png": "a42f069b03a9d0aa1b79bb976a997b79",
"assets/lib/assets/heroes/young/nu.png": "61b34234335e422a44eaad4bc8fc83e3",
"assets/lib/assets/heroes/young/ira.png": "c38fd4f8cf231d1935a149ee8360458a",
"assets/lib/assets/heroes/young/kayo2.png": "a6aa600df8e47145a8c6bec608505ea1",
"assets/lib/assets/heroes/young/betsy.png": "132ff97216d69d8655698d1e6d9eaecb",
"assets/lib/assets/heroes/young/boltyn.png": "09410223ef144385ff7c63840b24b786",
"assets/lib/assets/heroes/young/kayo.png": "dcd65b6cbd6f85b70d056c6aec04b922",
"assets/lib/assets/heroes/young/benji.png": "844e664ec7736849203904739206584c",
"assets/lib/assets/heroes/young/fai.png": "dc39c5dfc92bf1f048839bfb12a04199",
"assets/lib/assets/heroes/young/aurora2.png": "504ea4da0c2485691fe792c39c616f1c",
"assets/lib/assets/heroes/young/azalea.png": "1bc1497c47f7b6bbafbeeab165971044",
"assets/lib/assets/heroes/young/arakniweb.png": "885598dd53e2077a949877a60bd71d65",
"assets/lib/assets/heroes/young/chane.png": "c8c33a60e3af78b652cf0aefcf3638c0",
"assets/lib/assets/heroes/young/aurora.png": "4f2177cf7f40f594a0822c59b92389a0",
"assets/lib/assets/heroes/young/dash.png": "b02e670fa218c3feac81306d1eba515a",
"assets/lib/assets/heroes/young/dori.png": "1987c0b31a8dc522e2be4a4ec9042d2e",
"assets/lib/assets/heroes/young/lexi.png": "c9913d4f3aa084025fc03db81c57ba20",
"assets/lib/assets/heroes/young/kassai.png": "fb3d593e327b8e4fe1e79be3211b6432",
"assets/lib/assets/heroes/young/oscilio.png": "dc2263d587a00ec4e1757cca59ad856d",
"assets/lib/assets/heroes/young/verdance.png": "e0165eed35276e3270a21e3317b2665f",
"assets/lib/assets/heroes/young/kassai1.png": "6021521c488ae3206992f4c2e9a726fb",
"assets/lib/assets/heroes/young/riptide.png": "9b3c65c03667bdd3d63cbc7b2a1a1fe9",
"assets/lib/assets/heroes/young/cindra.png": "607819cbb8604b090dd533f431420cd2",
"assets/lib/assets/heroes/young/rhinar.png": "68d15460180fdaeead8fe6342b5e7822",
"assets/lib/assets/heroes/young/fang.png": "927ca7a4a9273244025273b815d4a196",
"assets/lib/assets/heroes/young/olympia.png": "f8c3514d715c51be20e8696935595759",
"assets/lib/assets/heroes/young/zen.png": "6c4cc07bd061ae8aa445d67deb1dd183",
"assets/lib/assets/heroes/young/dashdatabase.png": "43fa0edc537212dcfc84b05422f0838d",
"assets/lib/assets/heroes/young/kano.png": "eaced102d97b7cf2aaf0454e4e35d9bc",
"assets/lib/assets/heroes/young/enigma.png": "e68e87632ab04cc690537907dfd5a0b0",
"assets/lib/assets/heroes/rhinar.jpg": "1581be0f02978bc7e1f2c4cfe0da24c2",
"assets/lib/assets/heroes/ira.jpg": "f0df8a8dbed8d8d227011645ed39a044",
"assets/lib/assets/heroes/sea_preview_cover.webp": "1840d857a776e03ce74d144a6641c320",
"assets/lib/assets/heroes/levia.webp": "07808c405870493232528e0260553f9b",
"assets/lib/assets/heroes/kayo.jpeg": "317ac488dd879ee698ecf0005a323db8",
"assets/lib/assets/heroes/riptide.webp": "a6e9d87f961bbe0d4bb55b6b93f6a248",
"assets/lib/assets/heroes/prism.jpg": "7382f9ee30f9495468390effbce2bcc5",
"assets/lib/assets/heroes/maxx.webp": "bcd487507934e3b573025e3ea88af2b2",
"assets/lib/assets/heroes/viserai.jpg": "aae944c02c0d245de31e54a4d652a18f",
"assets/lib/assets/heroes/oscilio_cover.webp": "77d15e6992a5fc26d5934299180b2518",
"assets/lib/assets/heroes/azalea.webp": "0ec5cc186fe374d67fc19397b0c93886",
"assets/lib/assets/heroes/dash.jpg": "ca5c571dc6d4f6fd09d5daa37008d785",
"assets/lib/assets/heroes/betsy.webp": "a6630d6f81dcca44d48cecb2728479f8",
"assets/lib/assets/heroes/jarl.png": "668930f080de4cc0c170ce6a5534c012",
"assets/lib/assets/heroes/nuu_wide.webp": "c5c0c63e282d085f4fdba566d41d6349",
"assets/lib/assets/heroes/cindra.png": "540dc3adcd04b6c1e250ca0cd9a14380",
"assets/lib/assets/heroes/aurora_cover.webp": "07fe10a33b11dd52be8b64a4a9719c23",
"assets/lib/assets/heroes/arakniMario.png": "c07259c8cd450898ba7d15011b7361a8",
"assets/lib/assets/heroes/victor.webp": "00ab7b7824115bd6ea218b771e2969de",
"assets/lib/assets/heroes/dorinthea.png": "47e76b6e86258e95339549ef954f95d7",
"assets/lib/assets/heroes/florian_cover.webp": "3a2559ac0de016c3b66cbef7a8c35a12",
"assets/lib/assets/heroes/vynnset.webp": "e926dacbd9f950b17e56b9bdfaf75352",
"assets/lib/assets/heroes/olympia.webp": "d5d52be98ab7a6ba8188112c170b4443",
"assets/lib/assets/heroes/arakniSlippy.png": "09f6b944208cbbc6753b020b15d55eb0",
"assets/lib/assets/heroes/mst_spoilers.webp": "2eba519c24a42983439b253dbff6f6e3",
"assets/lib/assets/heroes/kano.png": "dfaa993bd2090c825e44c6416a3dfa7b",
"assets/lib/assets/heroes/fang_story.webp": "06e21817cc5f2ed7ef23c4cf1085798a",
"assets/lib/assets/heroes/verdance_cover.webp": "5e07cbb3eb1a14cf962b08081bfe1131",
"assets/lib/assets/heroes/enigma_wide.webp": "05b7a702a74915897fddbe5e39feed66",
"assets/lib/assets/heroes/kassai.webp": "a88d8357f38f2197e1d0ece48a8437c2",
"assets/AssetManifest.bin.json": "f1414ddd7b4d776a01baaf1e56a53ffb",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"manifest.json": "28ccfabdfbd8498cfe99a9b7af81a978",
"index.html": "0c4ade4382db4ead99cbc249b1db152d",
"/": "0c4ade4382db4ead99cbc249b1db152d",
"version.json": "bfa42ec333cd9463da9a5161559cb568",
"flutter_bootstrap.js": "9708f8804b1531d22707f5b9e81c1983",
"main.dart.js": "7ec2566ed70ef4f324f5c601be761e22",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"};
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
