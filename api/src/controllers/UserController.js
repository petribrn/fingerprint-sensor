import User from '../models/User';

class UserController {
  async store(req, res) {
    try {
      const newUser = await User.create(req.body);

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
      const users = await User.findAll({ attributes: ['name', 'fingerprint_id', 'created_at'] });
      return res.json(users);
    } catch (error) {
      return res.json(null);
    }
  }

  async show(req, res) {
    try {
      // const user = await User.findByPk(req.params.id);
      const user = await User.findOne({ where: { fingerprint_id: req.params.id } });
      const { name, fingerprint_id } = user;
      return res.json({ name, fingerprint_id });
    } catch (error) {
      return res.json(null);
    }
  }

  async update(req, res) {
    try {
      // const user = await User.findByPk(req.userId);
      const user = await User.findOne({ where: { fingerprint_id: req.params.id } });
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
      const user = await User.findOne({ where: { fingerprint_id: req.params.id } });
      if (!user) {
        return res.status(400).json({
          errors: ['User not found.'],
        });
      }
      // await arduinoAxios.post('/delete-fingerprint', { id: req.params.id });
      // CHECK IF IS POSSIBLE TO USE DELETE METHOD IN ARDUINO
      await user.destroy();

      return res.json(null);
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }
}

export default new UserController();
