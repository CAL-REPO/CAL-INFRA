import sys
import json
from jinja2 import Template

class TemplateRenderer:
    def __init__(self, template_path):
        with open(template_path, "r") as template_file:
            self.template_content = template_file.read()

    def render_template(self, variables):
        template = Template(self.template_content)
        rendered_config = template.render(**variables)
        return rendered_config

    def write_rendered_config(self, rendered_config, output_path):
        with open(output_path, "w") as output_file:
            output_file.write(rendered_config)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python <rederer_path> <template_path> <input_json> <output_path>")
        sys.exit(1)

    template_path = sys.argv[1]
    input_json_path = sys.argv[2]
    output_path = sys.argv[3]

    template_renderer = TemplateRenderer(template_path)

    with open(input_json_path, "r") as input_file:
        input_data = json.load(input_file)

    rendered_config = template_renderer.render_template(input_data)
    template_renderer.write_rendered_config(rendered_config, output_path)
