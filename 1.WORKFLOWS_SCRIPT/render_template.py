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
    template_renderer = TemplateRenderer("template.yaml")

    # Read JSON input from Terraform
    input_data = json.loads(sys.stdin.read())
    
    rendered_config = template_renderer.render_template(input_data)
    template_renderer.write_rendered_config(rendered_config, "cluster-config.yaml")
