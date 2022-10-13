"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _Student = require('../models/Student'); var _Student2 = _interopRequireDefault(_Student);
var _Photo = require('../models/Photo'); var _Photo2 = _interopRequireDefault(_Photo);

class StudentController {
  async index(req, res) {
    const students = await _Student2.default.findAll({
      attributes: ['id', 'name', 'last_name', 'email', 'age', 'weight', 'height'],
      order: [['id', 'DESC'], [_Photo2.default, 'id', 'DESC']],
      include: {
        model: _Photo2.default,
        attributes: ['filename', 'url'],
      },
    });
    return res.json(students);
  }

  async show(req, res) {
    try {
      if (!req.params.id) {
        return res.status(400).json({
          errors: ['Missing ID.'],
        });
      }

      const student = await _Student2.default.findByPk(req.params.id, {
        attributes: ['id', 'name', 'last_name', 'email', 'age', 'weight', 'height'],
        order: [['id', 'DESC'], [_Photo2.default, 'id', 'DESC']],
        include: {
          model: _Photo2.default,
          attributes: ['filename', 'url'],
        },
      });

      if (!student) {
        return res.status(400).json({
          errors: ['Student not found.'],
        });
      }

      return res.json(student);
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async store(req, res) {
    try {
      const student = await _Student2.default.create(req.body);
      return res.json(student);
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async update(req, res) {
    try {
      if (!req.params.id) {
        return res.status(400).json({
          errors: ['Missing ID.'],
          deleted: false,
        });
      }

      const student = await _Student2.default.findByPk(req.params.id);

      if (!student) {
        return res.status(400).json({
          errors: ['Student not found.'],
          deleted: false,
        });
      }

      const updatedStudent = await student.update(req.body);
      return res.json(updatedStudent);
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }

  async delete(req, res) {
    try {
      if (!req.params.id) {
        return res.status(400).json({
          errors: ['Missing ID.'],
          deleted: false,
        });
      }

      const student = await _Student2.default.findByPk(req.params.id);

      if (!student) {
        return res.status(400).json({
          errors: ['Student not found.'],
          deleted: false,
        });
      }

      await student.destroy();
      return res.json({ deleted: true });
    } catch (error) {
      return res.status(400).json({
        errors: error.errors.map((e) => e.message),
      });
    }
  }
}

exports. default = new StudentController();
