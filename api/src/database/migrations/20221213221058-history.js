module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('history', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      fingerprint_name: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: {
            tableName: 'users',
            schema: 'fingerprints',
          },
          key: 'name',
        },
      },
      access_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: {
            tableName: 'users',
            schema: 'fingerprints',
          },
          key: 'fingerprint_id',
        },
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
    });
  },

  async down(queryInterface) {
    await queryInterface.dropTable('history');
  },
};
