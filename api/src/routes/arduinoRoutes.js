import { Router } from 'express';
import arduinoController from '../controllers/ArduinoController';

const router = new Router();

router.get('/access-history', arduinoController.accessHistory); // Ok

router.get('/check-sensor-status', arduinoController.checkSensorStatus); // Ok
router.get('/init-sign-up/:id', arduinoController.initSignUpMode); // Ok
router.get('/first-read', arduinoController.firstRead); // Ok
router.get('/second-read', arduinoController.secondRead); // Ok

router.get('/check-fingerprint', arduinoController.checkFingerprint); // Ok

router.get('/get-fingerprint-count', arduinoController.getFingerprintSensorCount); // Ok
router.get('/empty-sensor-database', arduinoController.emptySensorDatabase); // Ok

export default router;
