from typer import Typer
from scripts.kata import app as kata_app

cli = Typer()
cli.add_typer(kata_app, name="kata", help="Kata CLI commands")

if __name__ == "__main__":
    cli()

