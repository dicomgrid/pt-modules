#cloud-config

write_files:
  - content: |
      ${license_content}
    path: /usr/local/trustgrid/license.txt
    permissions: "0644"
    owner: root:root
