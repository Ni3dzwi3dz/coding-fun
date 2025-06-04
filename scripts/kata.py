from typer import Typer, Argument, Option
from scripts.utils.kata import get_kata_dict, get_kata_path
from jinja2 import Environment, PackageLoader


app = Typer(
    name="kata",
    help="Manage CodeWars katas")



@app.command()
def copy(
    kata_id: str = Argument(..., help="The ID of the kata to copy"),
):
    kata_info = get_kata_dict(kata_id)

    title = kata_info.get("name","Unknown Kata")
    rank = kata_info.get("rank", 8).get("id", 8)
    description = kata_info.get("description", "No description available.")
    languages = kata_info.get("languages", [])
    url = kata_info.get("url", "https://www.codewars.com/kata/" + kata_id)


    kata_dir = get_kata_path(title, rank)

    if not kata_dir.exists():
        kata_dir.mkdir(parents=True, exist_ok=True)

    readme_path = kata_dir / "README.md"

    jinja_env = Environment(
        loader=PackageLoader("scripts","templates")
        )
    
    print(jinja_env.list_templates())
    
    template = jinja_env.get_template("kata_readme.template")

    rendered = template.render(
        title=title,
        description=description,
        languages=languages,
        link=url
    )

    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(rendered)