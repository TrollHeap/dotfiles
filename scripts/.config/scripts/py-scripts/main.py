import sys
import argparse
from api import OpenAIService, OllamaService

openai_service = OpenAIService()
ollama_service = OllamaService()


def get_user_input():
    """Parse the user input from command line arguments."""
    parser = argparse.ArgumentParser(description="Interact with AI models via Ollama (DeepSeek) or OpenAI")
    parser.add_argument("ask_input", type=str, help="The string to be used as input")
    parser.add_argument("--provider", type=str, choices=["deepseek", "openai"], default="deepseek",
                        help="Choose the AI provider (deepseek or openai)")
    return parser.parse_args()


def main():
    """Main function to handle the interaction flow."""
    args = get_user_input()

    if args.provider == "deepseek":
        ollama_service.chat_with_deepseek(args.ask_input)
    elif args.provider == "openai":
        messages = [{"role": "user", "content": args.ask_input}]
        openai_service.request_response_to_openai(messages)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n⛔️ Program terminated by user.")
        sys.exit(0)
