import argparse


def get_user_input():
    """Parse the user input from command line arguments."""
    parser = argparse.ArgumentParser(description="Interact with AI models via Ollama (DeepSeek) or OpenAI")
    parser.add_argument("ask_input", type=str, help="The string to be used as input")
    parser.add_argument("--provider", type=str, choices=["deepseek", "openai"], default="deepseek",
                        help="Choose the AI provider (deepseek or openai)")
    return parser.parse_args()
