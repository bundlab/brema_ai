import logging


def setup_logger():

    logger = logging.getLogger("brema")

    if logger.handlers:
        return logger

    logger.setLevel(logging.INFO)

    formatter = logging.Formatter(
        "%(asctime)s | %(levelname)s | %(message)s"
    )

    console = logging.StreamHandler()

    console.setFormatter(formatter)

    logger.addHandler(console)

    return logger


logger = setup_logger()
