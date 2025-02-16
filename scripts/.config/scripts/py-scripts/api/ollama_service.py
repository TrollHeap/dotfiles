import sys
from ollama import chat, ChatResponse


class OllamaService:
    """
    Service class to manage interactions with the DeepSeek AI model via Ollama.
    """

    DEFAULT_MODEL = "deepseek-r1:8b"

    def __init__(self, model: str = None):
        """
        Initializes the OllamaService with the default DeepSeek model.
        """
        self.model = model or self.DEFAULT_MODEL

    def chat_with_deepseek(self, user_input: str, stream: bool = True) -> None:
        """
        Sends user input to DeepSeek AI model via Ollama and streams the response.

        Args:
            user_input (str): The user's message.
            stream (bool): Whether to stream the response.
        """
        try:
            response: ChatResponse = chat(
                model=self.model,
                messages=[{'role': 'user', 'content': user_input}],
                stream=stream
            )

            if stream:
                for chunk in response:
                    print(chunk['message']['content'], end='', flush=True)
                print("\n")
            else:
                full_response = "".join(chunk['message']['content'] for chunk in response)
                print(full_response)

        except KeyboardInterrupt:
            print("\n⛔️ Interruption detected. Cancelling DeepSeek.")
            sys.exit(0)
        except Exception as e:
            print(f"Erreur lors de l'interaction avec DeepSeek : {e}")
