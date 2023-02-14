import gradio as gr

gr.Interface(lambda s: f"Hello, {s}", "textbox", "textbox").launch(auth=("admin", "admin"))