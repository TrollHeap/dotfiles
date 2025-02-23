import sys
from api.openai_service import OpenAIService
from api.ollama_service import OllamaService
from core.input import get_user_input

openai_service = OpenAIService()
ollama_service = OllamaService()


def main():
    """Main function to handle the interaction flow."""
    args = get_user_input()

    if args.provider == "deepseek":
        ollama_service.chat_with_deepseek(args.ask_input)
    elif args.provider == "openai":
        openai_service.request_response_to_openai(args.ask_input)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n⛔️ Program terminated by user.")
        sys.exit(0)
