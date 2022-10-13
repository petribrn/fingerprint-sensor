"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _sequelize = require('sequelize'); var _sequelize2 = _interopRequireDefault(_sequelize);

 class User extends _sequelize.Model {
  static init(sequelize) {
    super.init({
      name: {
        type: _sequelize2.default.STRING,
        defaultValue: '',
        allowNull: false,
        validate: {
          len: {
            args: [3, 255],
            msg: 'Name must be 3 to 255 characters long.',
          },
          notNull: {
            msg: 'Name must not be null.',
          },
        },
      },
      fingerprint_id: {
        type: _sequelize2.default.INTEGER,
        defaultValue: 0,
        allowNull: false,
        unique: true,
        validate: {
          min: 1,
          max: 149,
          notNull: {
            msg: 'Fingerprint ID must not be null.',
          },
        },
      },
    }, { sequelize });

    return this;
  }
} exports.default = User;
