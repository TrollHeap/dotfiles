from typing import List, Dict, Optional


class MessageHandler:
    """
    Handles message formatting and construction for AI interactions.
    Supports different roles, context handling, and structured output formats.
    """

    @staticmethod
    def format(
        user_input: str,
        role: str = "user",
        system_prompt: Optional[str] = None,
        previous_messages: Optional[List[Dict]] = None,
        response_format: Optional[str] = "text"
    ) -> List[Dict]:
        """
        Formats a message to be sent to an AI model with a specified role and optional system prompt.

        Args:
            user_input (str): The user's message.
            role (str): The role for the message (default: 'user').
            system_prompt (Optional[str]): Custom system instruction (e.g., TaskWarrior, RAG).
            previous_messages (Optional[List[Dict]]): Previous conversation messages for context.
            response_format (Optional[str]): Format of the response ('text' or 'json_schema').

        Returns:
            List[Dict]: A formatted message list for AI processing.
        """

        messages = previous_messages[:] if previous_messages else []

        # Add a system prompt if provided
        if system_prompt:
            messages.append({
                "role": "developer",
                "content": system_prompt
            })

        # Add the user's message
        messages.append({
            "role": role,
            "content": user_input
        })

        # Add response format if required (e.g., JSON Schema)
        if response_format == "json_schema":
            return {
                "messages": messages,
                "response_format": {
                    "type": "json_schema",
                    "json_schema": {
                        "name": "output_schema",
                        "schema": {
                            "type": "object",
                            "properties": {
                                "output": {
                                    "description": "Generated output",
                                    "type": "string"
                                }
                            },
                            "additionalProperties": False
                        }
                    }
                }
            }

        return messages
