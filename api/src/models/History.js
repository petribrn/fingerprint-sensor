import Sequelize, { Model } from 'sequelize';

export default class History extends Model {
  static init(sequelize) {
    super.init({
      fingerprint_name: {
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
      access_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
        allowNull: false,
        unique: true,
        validate: {
          min: 1,
          max: 149,
          notNull: {
            msg: 'Access ID must not be null.',
          },
        },
      },
    }, { sequelize });

    return this;
  }
}
