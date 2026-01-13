# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export VAULT_ADDR='http://0.0.0.0:8200'
export VAULT_API_ADDR='https://0.0.0.0:8200'
export VAULT_URL='https://0.0.0.0:8200'
