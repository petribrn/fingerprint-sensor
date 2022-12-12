import { Router } from 'express';
import userController from '../controllers/UserController';

const router = new Router();

router.get('/', userController.index);
router.get('/:id', userController.show);
router.post('/', userController.store);
router.put('/:id', userController.update);
router.delete('/:id', userController.delete);

router.get('/check-sensor-status', userController.checkSensorStatus);
router.get('/init-sign-up/:id', userController.initSignUpMode);
router.get('/first-read', userController.firstRead);
router.get('/second-read', userController.secondRead);
router.get('/check-fingerprint', userController.checkFingerprint);
router.get('/get-fingerprint-count', userController.getFingerprintSensorCount);
router.get('/empty-sensor-database', userController.emptySensorDatabase);

// router.post('/progress-message', userController.progressMessage);

export default router;
