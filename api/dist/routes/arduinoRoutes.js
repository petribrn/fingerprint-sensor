"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _express = require('express');
var _ArduinoController = require('../controllers/ArduinoController'); var _ArduinoController2 = _interopRequireDefault(_ArduinoController);

const router = new (0, _express.Router)();

router.get('/access-history', _ArduinoController2.default.accessHistory); // Ok

router.get('/check-sensor-status', _ArduinoController2.default.checkSensorStatus); // Ok
router.get('/init-sign-up/:id', _ArduinoController2.default.initSignUpMode); // Ok
router.get('/first-read', _ArduinoController2.default.firstRead); // Ok
router.get('/second-read', _ArduinoController2.default.secondRead); // Ok

router.get('/check-fingerprint', _ArduinoController2.default.checkFingerprint); // Ok

router.get('/get-fingerprint-count', _ArduinoController2.default.getFingerprintSensorCount); // Ok
router.get('/empty-sensor-database', _ArduinoController2.default.emptySensorDatabase); // Ok

exports. default = router;
