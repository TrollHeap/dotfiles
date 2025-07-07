# Configuration

Install with go package manager

`go install github.com/jorgerojas26/lazysql@latest`


If the XDG_CONFIG_HOME environment variable is set, the configuration file will be located at:

`${XDG_CONFIG_HOME}/lazysql/config.toml`

If not, the configuration file will be located at:

``` 
    Windows: %APPDATA%\lazysql\config.toml
    macOS: ~/Library/Application Support/lazysql/config.toml
    Linux: ~/.config/lazysql/config.toml
``` 

The configuration file is a TOML file and can be used to define multiple connections.
```toml
[[database]]
Name = 'Production database'
Provider = 'postgres'
DBName = 'foo'
URL = 'postgres://postgres:urlencodedpassword@localhost:${port}/foo'
Commands = [
  { Command = 'ssh -tt remote-bastion -L ${port}:localhost:5432', WaitForPort = '${port}' }
]
[[database]]
Name = 'Development database'
Provider = 'postgres'
DBName = 'foo'
URL = 'postgres://postgres:urlencodedpassword@localhost:5432/foo'
[application]
DefaultPageSize = 300
DisableSidebar = false
SidebarOverlay = false
``` 
