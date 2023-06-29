'use strict';

module.exports = function (environment) {
  let ENV = {
    modulePrefix: 'mutambo-web',
    podModulePrefix: 'mutambo-web/pods',
    environment,
    rootURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. EMBER_NATIVE_DECORATOR_SUPPORT: true
      },
      EXTEND_PROTOTYPES: {
        // Prevent Ember Data from overriding Date.parse.
        Date: false
      }
    },

    APP: {},
    app: {},
  };

  if (environment === 'development') {
    ENV.app = {
      apiUrl: '',
      gameSheetUrl: '',
      isProd: false,
      stripe_test_sku: '',
      stripe_key: '',
      firebase: {
        apiKey: "",
        authDomain: "",
        databaseURL: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
      }
    }
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    ENV.locationType = 'none'; // Testem prefers this...
    ENV.APP.LOG_ACTIVE_GENERATION = false; // keep test console output quieter
    ENV.APP.LOG_VIEW_LOOKUPS = false;
    ENV.APP.rootElement = '#ember-testing';
    ENV.APP.autoboot = false;
  }

  if (environment === 'production') {
    ENV.app = {
      apiUrl: '',
      gameSheetUrl: '',
      isProd: true,
      stripe_key: '',
      firebase: {
        apiKey: "",
        authDomain: "",
        databaseURL: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
      }
    }
  }

  return ENV;
};
