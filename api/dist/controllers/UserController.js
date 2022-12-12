"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _User = require('../models/User'); var _User2 = _interopRequireDefault(_User);
var _arduinoAxios = require('../services/arduinoAxios'); var _arduinoAxios2 = _interopRequireDefault(_arduinoAxios);

class UserController {
  async store(req, res) {
    try {
      const newUser = await _User2.default.create(req.body);

      const {
        id, name, fingerprint_id,
      } = newUser;
      return res.json({
        id, name, fingerprint_id,
      });
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async index(req, res) {
    try {
      const users = await _User2.default.findAll({ attributes: ['name', 'fingerprint_id'] });
      return res.json(users);
    } catch (error) {
      return res.json(null);
    }
  }

  async show(req, res) {
    try {
      // const user = await User.findByPk(req.params.id);
      const user = await _User2.default.findOne({ where: { fingerprint_id: req.params.id } });
      const { name, fingerprint_id } = user;
      return res.json({ name, fingerprint_id });
    } catch (error) {
      return res.json(null);
    }
  }

  async update(req, res) {
    try {
      // const user = await User.findByPk(req.userId);
      const user = await _User2.default.findOne({ where: { fingerprint_id: req.params.id } });
      if (!user) {
        return res.status(400).json({
          errors: ['User not found.'],
        });
      }

      const newUserData = await user.update(req.body);

      const { name } = newUserData;
      return res.json({ name });
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async delete(req, res) {
    try {
      // const user = await User.findByPk(req.userId);
      const user = await _User2.default.findOne({ where: { fingerprint_id: req.params.id } });
      if (!user) {
        return res.status(400).json({
          errors: ['User not found.'],
        });
      }
      await _arduinoAxios2.default.post('/delete-fingerprint', { id: req.params.id }); // CHECK IF IS POSSIBLE TO USE DELETE METHOD IN ARDUINO
      await user.destroy();

      return res.json(null);
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async checkSensorStatus(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/status');

      if (!arduinoResponse.data) {
        return null;
      }

      const isUp = arduinoResponse.data.isUp === 'true'; // TODO: Arduino integration to get this exact return

      return res.json({ data: { isUp } });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async initSignUpMode(req, res) {
    try {
      if (!req.params.id) return false;

      const arduinoResponse = await _arduinoAxios2.default.post('/newfingerprint', { id: req.params.id });

      if (!arduinoResponse.data) return false;

      return res.json({
        data: {
          signUpMode: true,
          message: 'Posicione o dedo no sensor',
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async firstRead(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/first-read');

      if (!arduinoResponse) return res.json({ data: { error: 'Did not get any response from arduino' } });

      const { removeFinger } = arduinoResponse.data;

      return res.json({
        data: {
          doneFirstRead: true,
          message: removeFinger,
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async secondRead(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/second-read');

      if (!arduinoResponse) return res.json({ data: { error: 'Did not get any response from arduino' } });

      const { fingerprintId, message } = arduinoResponse.data;

      return res.json({
        data: {
          doneSecondRead: true,
          fingerprintId,
          message,
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async checkFingerprint(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/check-fingerprint');

      if (!arduinoResponse) return res.json({ data: { error: 'Fingerprint not found' } });

      const { foundId, confidence } = arduinoResponse.data;

      const user = await _User2.default.findOne({ where: { fingerprint_id: foundId } });

      if (!user) return res.json({ data: { error: 'User not found in cloud db.' } });

      const { name } = user;

      return res.json({
        data: {
          name,
          foundId,
          confidence,
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async getFingerprintSensorCount(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/get-fingerprint-count');

      if (!arduinoResponse) return res.json({ data: { error: 'Did not get any response from arduino' } });

      const { fingerprintCount } = arduinoResponse.data;

      return res.json({
        data: {
          fingerprintCount,
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async emptySensorDatabase(req, res) {
    try {
      const arduinoResponse = await _arduinoAxios2.default.get('/empty-database');

      if (!arduinoResponse) return res.json({ data: { error: 'Did not get any response from arduino' } });

      return res.json({
        data: {
          emptySensorDB: true,
        },
      });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  // async progressMessage(req, res) {
  //   try {
  //     const { message } = req.body;

  //     const response = await appAxios.post('/progress-message', { message });

  //     return res.json({
  //       data: {
  //         messageSent: true,
  //         response,
  //       },
  //     });
  //   } catch (error) {
  //     return res.status(400).json(error.toJSON());
  //   }
  // }
}

exports. default = new UserController();

/*
index -> list all - GET
store/create ->  create new - POST
delete -> delete one - DELETE
show -> show one - GET
update -> updates one - PATCH (only one attribute) or PUT (full object)
*/
