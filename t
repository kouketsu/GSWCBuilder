language: julia
os:
  - linux
julia:
  - 1.2
notifications:
  email: false
git:
  depth: 99999999
cache:
  timeout: 1000
  directories:
    - downloads
env:
  global:
    - BINARYBUILDER_DOWNLOADS_CACHE=downloads
    - BINARYBUILDER_AUTOMATIC_APPLE=true
sudo: required

# Before anything else, get the latest versions of things # for 1.2 BinaryBuilder (stable) not #master
before_script:
  - julia -e 'using Pkg; pkg"add BinaryProvider"; pkg"add BinaryBuilder"; Pkg.build()'

script:
  - julia build_tarballs.jl


deploy:
    provider: releases
    api_key:
        # Note; this api_key is only valid for kouketsu/GSWCBuilder; you need
        # to make your own: https://docs.travis-ci.com/user/deployment/releases/
        secure: gn/82Fe3UyqtAsHZBHxBT0yhomoPDYpKeQSbHfFnid+SBIM+PfWqsKQCj+76qJCgPIJLZ06ZKyihoh4OWNenvhlP2Ix78rZ/QWOPyuEcvzgn6bGweSGO7fzpU/lx79YnO6brYuoEzbYiTyw5jSlvY5ia59/44c6ghpzkIENa99Ca3A9j/XRV1p9FDKad38Hc91DmJBARYNmEfC8a8fIw4QJ1Z4iDIL9P0bYvdD+iMnGSnZligQkclHdWFJY+8J9Bwf9tz5siDvzHXSS5dIK0EyEXNd1OfbIYERBQO8XAinEKZMXmr3LxG9EV+NO03lwi2vY2jmuZ4tOvzQOEfon6kvTxsjGTTUPUjNCjAUcomO+NoyedkcQ8kZAPVzRZMR7gI15KieUpZveFuZGF/TNHH3XaSQc1E9/MJXqwkdq6ycs2OX1MhXhRDbLMxRJhGYteYyKVMMVIIJDfFzj0FY7T6Qd5yVx+74aQA/J/heCfJXzamDcETw7RMV3rjxDCWwa4g4HtoMVt4foLiuS4dxrJ/n36mP2aCluK02DW85MKN2SgepMv0ZBboDJMqdJpMsKkbVoGPNANVbr37CvU9RFxLfkJoG+xL7SSrbQretoHX63NiVvgz0rfmDEQr0G/qeSdZKs9U55Y0823dNWJ3RIzOmHFf6/OCIsk2BerqV3cvs4=
    file_glob: true
    file: products/*
    skip_cleanup: true
    on:
        repo: kouketsu/GSWCBuilder
        tags: true
