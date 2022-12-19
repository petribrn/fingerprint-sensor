import User from '../models/User';
import Access from '../models/Access';
import arduinoAxios from '../services/arduinoAxios';

class ArduinoController {
  async checkSensorStatus(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/status');

      if (!arduinoResponse.data) {
        return null;
      }

      const isUp = arduinoResponse.data.isUp === 'true'; // TODO: Arduino integration to get this exact return

      return res.json({ data: { isUp } });
    } catch (error) {
      return res.status(400).json(error.toJSON());
    }
  }

  async accessHistory(req, res) {
    try {
      const history = await Access.findAll({ attributes: ['access_id', 'fingerprint_name', 'read_at'] });
      return res.json(history);
    } catch (error) {
      return res.json(null);
    }
  }

  async initSignUpMode(req, res) {
    try {
      if (!req.params.id) return false;

      const arduinoResponse = await arduinoAxios.post('/newfingerprint', { id: req.params.id });

      if (!arduinoResponse.data) return false;

      return res.json({
        data: {
          id: req.params.id,
          signUpMode: true,
          message: 'Posicione o dedo no sensor',
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }

  async firstRead(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/first-read');

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
      const arduinoResponse = await arduinoAxios.get('/second-read');

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
      const arduinoResponse = await arduinoAxios.get('/check-fingerprint');

      if (!arduinoResponse) return res.json({ data: { error: 'Fingerprint not found' } });

      const { foundId, confidence } = arduinoResponse.data;

      const user = await User.findOne({ where: { fingerprint_id: foundId } });

      if (!user) return res.json({ data: { error: 'User not found in cloud db.' } });

      const { name, fingerprint_id } = user;

      const timeElapsed = Date.now();
      let currentDatetime = new Date(timeElapsed);
      currentDatetime = currentDatetime.toLocaleString('pt-BR');

      const access = await Access.create({
        fingerprint_name: name,
        access_id: fingerprint_id,
        read_at: currentDatetime,
      });

      if (!access) return res.status(400).json({ data: { error: 'Fail to register access.' } });

      return res.json({
        data: {
          name,
          foundId,
          confidence,
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }

  async getFingerprintSensorCount(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/get-fingerprint-count');

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
      const arduinoResponse = await arduinoAxios.get('/empty-database');

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
}

export default new ArduinoController();
