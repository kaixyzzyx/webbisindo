# Database Configuration
import os

class Config:
    # MySQL Database Configuration
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'localhost')
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', '')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'db_bisindo')
    MYSQL_PORT = int(os.environ.get('MYSQL_PORT', 3306))
    
    # Flask Configuration
    SECRET_KEY = os.environ.get('SECRET_KEY', 'bisindo_secret_key_2024')
    
    @staticmethod
    def get_db_config():
        return {
            'host': Config.MYSQL_HOST,
            'user': Config.MYSQL_USER,
            'password': Config.MYSQL_PASSWORD,
            'database': Config.MYSQL_DB,
            'port': Config.MYSQL_PORT,
            'autocommit': True
        }