
include:
  - .optimize
  - .boot
  - .udev
  - .config

hosts-file-configured:
  host.only:
    - name: 127.0.1.1
    - hostnames:
      - {{ salt['grains.get']('host') }}

pi-user-aliases-configured:
  file.managed:
    - name: /home/pi/.bash_aliases
    - contents:
      - alias autopitest="autopi state.sls checkout.test"
    - user: pi
    - group: pi

haveged-installed:
  pkg.installed:
    - name: haveged

haveged-service-running:
  service.running:
    - name: haveged

package-manager-reconfigured:
  cmd.run:
    - name: "dpkg --configure -a"
    - onfail:
      - pkg: haveged
