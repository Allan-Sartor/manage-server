#!/bin/bash
set -e

# Remover um possível PID do servidor, se existir, para evitar conflitos
rm -f /myapp/tmp/pids/server.pid

# Executar o comando principal do contêiner
exec "$@"
