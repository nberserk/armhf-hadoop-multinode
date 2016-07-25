#!/usr/bin/python

import sys
import getopt
import tempfile
from subprocess import check_output, CalledProcessError

docker_images='10.240.70.80:5000/armhf-spark-master', '10.240.70.80:5000/armhf-spark-slave'

def _convert_opts(opts):
    """
    Convert list with command options to single string value
    with 'space' delimeter
    :param opts: list with space-delimeted values
    :return: string with space-delimeted values
    """
    return ' '.join(opts)


def _exec_command(adb_cmd, isStrict=True):
    """
    Format adb command and execute it in shell
    :param adb_cmd: list adb command to execute
    :return: string '0' and shell command output if successful, otherwise
    raise CalledProcessError exception and return error code
    """
    t = tempfile.TemporaryFile()
    final_adb_cmd = []
    for e in adb_cmd:
        if e != '':  # avoid items with empty string...
            final_adb_cmd.append(e)  # ... so that final command doesn't
            # contain extra spaces
    print('\n*** Executing ' + ' '.join(adb_cmd) + ' ' + 'command')

    try:
        output = check_output(final_adb_cmd, stderr=t)
    except CalledProcessError as e:
        t.seek(0)
        result = e.returncode, t.read()
        print('\n'+ result[1])
        if isStrict:
            raise e
    else:
        result = 0, output
        print('\n' + result[1])

    return result

def pushFile(prefix, localPath, phonePath):
    cmd = list(prefix)
    cmd = cmd + ['push', localPath, phonePath]
    _exec_command(cmd)

def shell(prefix, args, isStrict=True):
    cmd = list(prefix)
    cmd.append('shell')
    cmd += args
    _exec_command(cmd, isStrict)

def run_docker(deviceId, hostname):
    prefix = ['fb-adb', '-s']
    prefix.append(deviceId)
    docker = 'docker-1.10.2'

    # hosts
    pushFile(prefix, 'hosts', '/etc/hosts')    

    #
    shell(prefix, ['echo ' + hostname + ' > /proc/sys/kernel/hostname'])

    
    if hostname == 'master':
        dockerImage = 'nberserk/armhf-spark-master'
    else:
        dockerImage = 'nberserk/armhf-spark-slave'
    dockerImage += ':0.4'

    shell(prefix, [docker, 'rm', '-f', 'spark'], False)
    shell(prefix, ['date', '0721000016'])
    shell(prefix, [docker, 'pull', dockerImage])

    fullCmd = docker + ' run -d -e MASTER=192.168.0.23 -e SLAVES=s1,s2,s3 --name spark --net=host ' + dockerImage
    shell(prefix, fullCmd.split(' ') )

def main():
    #shell( ['fb-adb', '-s', '5f1b469e' ], ['echo master > /proc/sys/kernel/hostname'])
    exit 

    run_docker('fb56d221', 's1')
    run_docker('670563db', 's2')
    run_docker('c8fe45c9', 's3')
    run_docker('5f1b469e', 'master')

    #_exec_command(['adb', '-s', '5f1b469e' , 'shell',  'cat', '/etc/hosts'])
    #_exec_command(['adb', '-s', '5f1b469e',  'cat', '/etc/hosts'])

    
  # try:
    #     opts, args = getopt.getopt(sys.argv[1:],"abchi:o:",["input=","output=","help"])
  # except getopt.GetoptError as err:
  #     print str(err)
  #     help()
  #     sys.exit(1)
      
  # for opt,arg in opts:
  #   if (opt == "-a"):
  #       print "a option enabled"
  #   elif ( opt == "-b"):
  #       print "b option enabled"
  #   elif ( opt == "-c"):
  #       print "c option enabled"
  #   elif ( opt == "-i" ) or ( opt == "--input"):
  #       print "input file = "+arg
  #   elif ( opt == "-o") or ( opt == "--output"):
  #       print "ouput file = "+arg
  #   elif ( opt == "-h") or ( opt == "--help"):
  #       help()
        
        

if __name__ == '__main__':
    main()


    
