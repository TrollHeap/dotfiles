from openai import OpenAI
from core.message_handler import MessageHandler


class OpenAIService:
    """
    A Singleton service class to manage all interactions with the OpenAI API.
    """
    DEFAULT_MODEL = "gpt-4o-mini"

    def __init__(self, model: str = None):
        """
        Initializes the OpenAIService with the OpenAI client and model.
        """
        self.model = model or self.DEFAULT_MODEL
        self._client = self._setup_client()

    def _setup_client(self) -> OpenAI:
        """
        Initializes and validates the OpenAI client.
        """
        try:
            api_key = OpenAIKey().api_key  # Fetch API key from OpenAIKey
            client = OpenAI(api_key=api_key)
            client.models.list()  # Validate the client by listing models
            return client
        except Exception as e:
            raise ValueError(f"Failed to initialize OpenAI client: {e}")

            # TODO: ADAPTER LA FONCTION EN LIEN AVEC LA NOUVELLE CLASS MessageHandler
    def request_response_to_openai(self, user_input: str) -> str:
        """
        Sends a message to the OpenAI API and returns the response.

        Args:
            user_input (str): The user's message.

        Returns:
            str: The content of the first message in the response.
        """
        try:

            # HACK: CELLE-CI
            messages = MessageHandler.format(user_input)

            response = self._client.chat.completions.create(
                model=self.model,
                messages=messages
            )

            print(response.choices[0].message.content)
            return response.choices[0].message.content

        except Exception as e:
            raise ValueError(f"Failed to process the request: {e}")


class OpenAIKey:
    """
    A Class to manage the OpenAI API key.
    """

    def __init__(self, api_key: str = None):
        """
        Initializes the OpenAIKey instance with an API key.
        """
        self._api_key = api_key or self._load_api_key()

    def _load_api_key(self) -> str:
        """
        Loads the OpenAI API key from the settings.
        """
        from config.settings import settings
        api_key = settings.OPENAI_API_KEY
        if not api_key:
            raise ValueError("API key is missing. Please set it in the environment or .env file.")
        return api_key

    @property
    def api_key(self) -> str:
        """
        Getter for the API key.
        """
        return self._api_key
