import Sequelize, { Model } from 'sequelize';

export default class User extends Model {
  static init(sequelize) {
    super.init({
      name: {
        type: Sequelize.STRING,
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
        type: Sequelize.INTEGER,
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
}
