import threading
from functools import wraps
from typing import Type, TypeVar, Callable, Dict, Any

T = TypeVar('T')


class SingletonMeta:
    """
    A thread-safe Singleton metaclass.
    """
    instances: Dict[Type[T], T] = {}
    lock = threading.Lock()

    @staticmethod
    def reset_instances():
        SingletonMeta.instances.clear()


def singleton(cls: Type[T]) -> Callable[..., T]:
    """
    A thread-safe decorator to turn a class into a Singleton.
    """
    @wraps(cls)
    def wrapper(*args: Any, **kwargs: Any) -> T:
        with SingletonMeta.lock:
            if cls not in SingletonMeta.instances:
                SingletonMeta.instances[cls] = cls(*args, **kwargs)
        return SingletonMeta.instances[cls]

    return wrapper
