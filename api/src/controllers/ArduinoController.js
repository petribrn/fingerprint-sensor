import User from '../models/User';
import Access from '../models/Access';
import arduinoAxios from '../services/arduinoAxios';

class ArduinoController {
  async checkSensorStatus(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/status');

      if (!arduinoResponse) {
        return null;
      }

      return res.json({ data: { isUp: arduinoResponse.data.isUp } });
    } catch (error) {
      return res.json(error);
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
      if (!req.params.id) return res.json(null);

      const user = await User.findOne({ where: { fingerprint_id: req.params.id } });

      if (user) return res.json({ data: { error: 'Id da digital já cadastrado' } });

      const arduinoResponse = await arduinoAxios.post('/newfingerprint', { id: req.params.id });

      if (!arduinoResponse.data) return res.json(null);

      if (!arduinoResponse.data.initSignUp) return res.json(null);

      return res.json({
        data: {
          id: req.params.id,
          signUpMode: arduinoResponse.data.initSignUp,
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

      if (!arduinoResponse) return res.json(null);

      if (arduinoResponse.data.error) return res.json({ error: arduinoResponse.data.error });

      const { removeFinger } = arduinoResponse.data;

      return res.json({
        data: {
          doneFirstRead: true,
          message: removeFinger,
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }

  async secondRead(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/second-read');

      if (!arduinoResponse) return res.json(null);

      if (arduinoResponse.data.error) return res.json({ error: arduinoResponse.data.error });

      const { fingerprintId, doneSecondRead } = arduinoResponse.data;

      return res.json({
        data: {
          doneSecondRead,
          fingerprintId,
          message: 'Leitura concluída',
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }

  async checkFingerprint(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/check-fingerprint');

      if (!arduinoResponse) return res.json(null);

      if (arduinoResponse.data.error) return res.json({ error: arduinoResponse.data.error });

      const { foundId, confidence } = arduinoResponse.data;

      const user = await User.findOne({ where: { fingerprint_id: foundId } });

      if (!user) return res.json(null);

      const { name, fingerprint_id } = user;

      const timeElapsed = Date.now();
      let currentDatetime = new Date(timeElapsed);
      currentDatetime = currentDatetime.toLocaleString('pt-BR');

      const access = await Access.create({
        fingerprint_name: name,
        access_id: fingerprint_id,
        read_at: currentDatetime,
      });

      if (!access) return res.json(null);

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

      if (!arduinoResponse) return res.json(null);

      const { fingerprintCount } = arduinoResponse.data;

      return res.json({
        data: {
          fingerprintCount,
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }

  async emptySensorDatabase(req, res) {
    try {
      const arduinoResponse = await arduinoAxios.get('/empty-database');

      if (!arduinoResponse) return res.json(null);

      return res.json({
        data: {
          emptySensorDB: true,
        },
      });
    } catch (error) {
      return res.status(400).json(error);
    }
  }
}

export default new ArduinoController();
