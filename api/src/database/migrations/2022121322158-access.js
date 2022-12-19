module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('accesses', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      fingerprint_name: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      access_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      read_at: {
        type: Sequelize.STRING,
        allowNull: false,
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
    await queryInterface.dropTable('accesses');
  },
};
