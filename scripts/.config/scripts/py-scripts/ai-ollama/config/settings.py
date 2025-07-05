import os


class Settings:
    """
    Application-wide configuration settings without using dotenv.
    """

    def __init__(self, env_file=".env"):
        self.load_env(env_file)
        self.OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

    def load_env(self, env_file):
        """Manually load environment variables from a .env file."""
        if not os.path.exists(env_file):
            print(f"⚠ Warning: {env_file} not found.")
            return

        with open(env_file, "r") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):  # Ignore empty lines and comments
                    key, value = line.split("=", 1)
                    os.environ[key] = value  # Set the variable in the environment


# Initialize settings
settings = Settings()

# Test the API key
print("Processing generation response...")
