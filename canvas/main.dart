library main;
import 'dart:html';
import 'dart:web_gl';

RenderingContext gl;

void main()
{
  CanvasElement canvas = querySelector("#canvas");
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  
  gl = canvas.getContext("webgl");
  if(gl == null) gl = canvas.getContext("experimental-webgl");
  
  window.onResize.listen((_) => onResize());
  onResize();
  
  gl.clearColor(1, 0, 0, 1);
  gl.clear(COLOR_BUFFER_BIT);
}

void onResize()
{
  CanvasElement canvas = querySelector("#canvas");
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  gl.viewport(0, 0, canvas.width, canvas.height);
}