c = get_config()  #obtener el objeto de configuración
c.IPKernelApp.pylab = 'inline'  # figura en línea cuando se usa Matplotlib
c.NotebookApp.ip = '0.0.0.0'  
c.NotebookApp.open_browser = False  # no abra una ventana del navegador de forma predeterminada cuando use cuadernos
c.NotebookApp.token = '' # Sin token. Siempre use jupyter sobre el túnel ssh
c.NotebookApp.notebook_dir = '/root/notebooks' # direcctorio de nuestros notebooks
c.NotebookApp.allow_root = True # Permitir ejecutar Jupyter desde el usuario raíz dentro del contenedor Docker
c.NotebookApp.allow_origin = '*'
c.NotebookApp.tornado_settings = { 
    'headers': { 
        'Content-Security-Policy': "frame-ancestors 'self' *" 
    }
}
