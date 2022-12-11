"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _express = require('express');
var _UserController = require('../controllers/UserController'); var _UserController2 = _interopRequireDefault(_UserController);

const router = new (0, _express.Router)();

router.get('/', _UserController2.default.index);
router.get('/:id', _UserController2.default.show);
router.post('/', _UserController2.default.store);
router.put('/:id', _UserController2.default.update);
router.delete('/:id', _UserController2.default.delete);

router.get('/check-sensor-status', _UserController2.default.checkSensorStatus);
router.get('/init-sign-up', _UserController2.default.initSignUpMode);
router.get('/first-read', _UserController2.default.firstRead);
router.get('/second-read', _UserController2.default.secondRead);
router.get('/check-fingerprint', _UserController2.default.checkFingerprint);
router.get('/get-fingerprint-count', _UserController2.default.getFingerprintSensorCount);
router.get('/empty-sensor-database', _UserController2.default.emptySensorDatabase);

// router.post('/progress-message', userController.progressMessage);

exports. default = router;
