library scene;

import 'dart:web_gl';
import 'dart:typed_data';

RenderingContext gl;

init(RenderingContext renderingContext)
{
  gl = renderingContext;
  
  // Compile the vertex shader.
  Shader vertexShader = gl.createShader(VERTEX_SHADER);
  gl.shaderSource(vertexShader, 
  """
    attribute vec3 a_pos;
    void main() 
    {
      gl_Position = vec4(a_pos.x - 0.5, a_pos.y - 0.5, 0, 2.0);
    }
  """);
  
  gl.compileShader(vertexShader);
  if(!gl.getShaderParameter(vertexShader, COMPILE_STATUS))
  {
    throw gl.getShaderInfoLog(vertexShader);
  }
  
  // Compile the fragment shader.
  Shader fragmentShader = gl.createShader(FRAGMENT_SHADER);
  gl.shaderSource(fragmentShader, 
  """
    void main() 
    {
      gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
  """);
  
  gl.compileShader(fragmentShader);
  if(!gl.getShaderParameter(fragmentShader, COMPILE_STATUS))
  {
    throw gl.getShaderInfoLog(fragmentShader);
  }

  // Link the shadrers into a runnable program.
  Program program = gl.createProgram();
  gl.attachShader(program, vertexShader);
  gl.attachShader(program, fragmentShader);
  gl.linkProgram(program);
  if (!gl.getProgramParameter(program, LINK_STATUS)) 
  {
    throw gl.getProgramInfoLog(program);
  }
  
  // Make the program current.
  gl.useProgram(program);
  
  // Obtain the handle to the shader program's position attribute.
  int posLocation = gl.getAttribLocation(program, 'a_pos');
  
  // Create a vertex buffer that defines a rectangle.
  Buffer vertexBuffer = gl.createBuffer();
  gl.bindBuffer(ARRAY_BUFFER, vertexBuffer);
  Float32List vertexArray = new Float32List.fromList([
     0.0, 0.0, 0.0,
     0.0, 1.0, 0.0,
     1.0, 0.0, 0.0,
     1.0, 1.0, 0.0                                   
  ]);
  
  gl.bufferDataTyped(ARRAY_BUFFER, vertexArray, STATIC_DRAW);
  
  gl.enableVertexAttribArray(posLocation);
  gl.vertexAttribPointer(posLocation, 3, FLOAT, false, 0, 0);
  
  gl.clearColor(1, 1, 1, 1);
  gl.clear(COLOR_BUFFER_BIT);
  gl.drawArrays(TRIANGLE_STRIP, 0, 4);
}