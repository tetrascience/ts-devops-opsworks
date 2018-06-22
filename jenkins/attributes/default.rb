default['java']['jdk_version']    = '8'
default['java']['install_flavor'] = 'openjdk'

default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'
default['jenkins']['username']  = "admin"
default['jenkins']['password']  = "admin"
default['jenkins']['version']   = "2.107.2"

default['okta']['idpmetadata'] = '''
PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48bWQ6RW50aXR5RGVzY3JpcHRvciB4bWxuczptZD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOm1ldGFkYXRhIiBlbnRpdHlJRD0iaHR0cDovL3d3dy5va3RhLmNvbS9leGsxMXpoejViNzNtWjZCVzJwNyI+PG1kOklEUFNTT0Rlc2NyaXB0b3IgV2FudEF1dGhuUmVxdWVzdHNTaWduZWQ9ImZhbHNlIiBwcm90b2NvbFN1cHBvcnRFbnVtZXJhdGlvbj0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOnByb3RvY29sIj48bWQ6S2V5RGVzY3JpcHRvciB1c2U9InNpZ25pbmciPjxkczpLZXlJbmZvIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIj48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlEcURDQ0FwQ2dBd0lCQWdJR0FXTC9CWlkxTUEwR0NTcUdTSWIzRFFFQkN3VUFNSUdVTVFzd0NRWURWUVFHRXdKVlV6RVRNQkVHCkExVUVDQXdLUTJGc2FXWnZjbTVwWVRFV01CUUdBMVVFQnd3TlUyRnVJRVp5WVc1amFYTmpiekVOTUFzR0ExVUVDZ3dFVDJ0MFlURVUKTUJJR0ExVUVDd3dMVTFOUFVISnZkbWxrWlhJeEZUQVRCZ05WQkFNTURHNWpiRzkxWkhNdGMyaGhiakVjTUJvR0NTcUdTSWIzRFFFSgpBUllOYVc1bWIwQnZhM1JoTG1OdmJUQWVGdzB4T0RBME1qVXlNalUxTVRoYUZ3MHlPREEwTWpVeU1qVTJNVGhhTUlHVU1Rc3dDUVlEClZRUUdFd0pWVXpFVE1CRUdBMVVFQ0F3S1EyRnNhV1p2Y201cFlURVdNQlFHQTFVRUJ3d05VMkZ1SUVaeVlXNWphWE5qYnpFTk1Bc0cKQTFVRUNnd0VUMnQwWVRFVU1CSUdBMVVFQ3d3TFUxTlBVSEp2ZG1sa1pYSXhGVEFUQmdOVkJBTU1ERzVqYkc5MVpITXRjMmhoYmpFYwpNQm9HQ1NxR1NJYjNEUUVKQVJZTmFXNW1iMEJ2YTNSaExtTnZiVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFEZ2dFUEFEQ0NBUW9DCmdnRUJBSVFmSnAxS0dGMTNadFUra3ZuQTQwOFdQeDRtQTUwM3JFUWU4K3lYZFJFNFNqWUliM0lOQlFBVEJYWjNtYkF3OXhGdlZuOTgKbExweDZnVXZpdWpvZjJTNFR0aXRVMXVuQi9pWjRSWFB1T204VlJVQ1pDVXE4RWxrVjRpdnNRZTBQSFBhR3h3VkZiV1YwRHR2Qkt1MApuOXJRc1l6UFRyN29PUkJrMkxaM096bjBmaHFwYXNISHV3bW9JNTU0T0lJbjRUZFhYRlA2WkFhdGk3MS9KRHRNWkswZnV6MXpvR3I4CkdXQjlvUkxkVVpkV0lJMXUveTJCODBLemExY3ZCQ3Y0bElQUlZmdGxzcktmR2NhRFQrS3J0WThNZFBjSmJzdDFiOTVGKzhmYTZMNmgKVVJqS3hWanlINVRqM1gxM2haWThoTldwcnNmUkNxRVdPVW1jMzYvZU9La0NBd0VBQVRBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQQpDOVpuUzVqeXZITkRhSDFGbng3ZkREdTMwazlOT1pGeWlydHQ1Y1VFMndYZS9lc1RhT1BMRTZjaTR2Nlh5bW5HM1hkcGJ3VENBQ2lkCmNSZU96MVBXbkRuSDVIWm85UVl0MEVaWWtjd0JrK042UGRURzdGRENmejVNUzFNaCt1Wm9tdG9UNjNtRkNBeFRaaDRaZ2pGRHdNWG0KaHJXZGRwL20xKy9XcmxKN3cyMXNvbFlUVStoR2tDTjh6QVN6cjNlUWJjRDM4bWhNMHdlbEJBalBlb09ZY3lZRlVudHgzNDVoRXg0NgpZbGg1VklDVmtkZlhLcWRvWjBoekdVV2FzK2JseHJVT1ZTdzdZQ1MxYkNuOTRMSGxLL2hPTWt0UjZDdVpqUm80bStjREtqZDlPNWZyCnF2T25lenJ4S1YwMDdoZ0E5bDlaY0VlWHJBZ2FzcnZDN1g4bitBPT08L2RzOlg1MDlDZXJ0aWZpY2F0ZT48L2RzOlg1MDlEYXRhPjwvZHM6S2V5SW5mbz48L21kOktleURlc2NyaXB0b3I+PG1kOk5hbWVJREZvcm1hdD51cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoxLjE6bmFtZWlkLWZvcm1hdDp1bnNwZWNpZmllZDwvbWQ6TmFtZUlERm9ybWF0PjxtZDpOYW1lSURGb3JtYXQ+dXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6MS4xOm5hbWVpZC1mb3JtYXQ6ZW1haWxBZGRyZXNzPC9tZDpOYW1lSURGb3JtYXQ+PG1kOlNpbmdsZVNpZ25PblNlcnZpY2UgQmluZGluZz0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmJpbmRpbmdzOkhUVFAtUE9TVCIgTG9jYXRpb249Imh0dHBzOi8vbmNsb3Vkcy1zaGFuLm9rdGEuY29tL2FwcC9qZW5raW5zL2V4azExemh6NWI3M21aNkJXMnA3L3Nzby9zYW1sIi8+PG1kOlNpbmdsZVNpZ25PblNlcnZpY2UgQmluZGluZz0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmJpbmRpbmdzOkhUVFAtUmVkaXJlY3QiIExvY2F0aW9uPSJodHRwczovL25jbG91ZHMtc2hhbi5va3RhLmNvbS9hcHAvamVua2lucy9leGsxMXpoejViNzNtWjZCVzJwNy9zc28vc2FtbCIvPjwvbWQ6SURQU1NPRGVzY3JpcHRvcj48L21kOkVudGl0eURlc2NyaXB0b3I+Cg==
'''.strip