package dapp

import (
	"os"
	"path/filepath"
)

func GetHomeDir() string {
	if val, ok := os.LookupEnv("DAPP_HOME"); ok {
		return val
	}
	return filepath.Join(os.Getenv("HOME"), ".dapp")
}

func GetTmpDir() string {
	if val, ok := os.LookupEnv("DAPP_TMP"); ok {
		return val
	}
	return os.TempDir()
}

/* TODO: will be needed for single go-dapp binary
func Init() error {
		TmpDir, err = ioutil.TempDir("", "dapp-")
		if err != nil {
			return fmt.Errorf("cannot create temporary dir: %s", err)
		}

		interruptCh := make(chan os.Signal, 1)
		signal.Notify(interruptCh, syscall.SIGINT, syscall.SIGTERM)

		go func() {
			<-interruptCh
			err := Terminate()
			if err != nil {
				fmt.Fprintf(os.Stderr, "Error terminating dapp: %s", err)
			}
			fmt.Fprintf(os.Stderr, "Exiting")
			os.Exit(1)
		}()

	return nil
}

func Terminate() error {
		err := os.RemoveAll(TmpDir)
		if err != nil {
			return fmt.Errorf("cannot remove temporary dir: %s", err)
		}

	return nil
}
*/
