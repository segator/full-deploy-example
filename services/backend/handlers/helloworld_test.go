package handlers

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHelloworld(t *testing.T) {
	w := httptest.NewRecorder()
	helloFunction(w, nil)

	resp := w.Result()
	if have, want := resp.StatusCode, http.StatusOK; have != want {
		t.Errorf("Status code is wrong. Have: %d, want: %d.", have, want)
	}

	helloWorldResponse, err := ioutil.ReadAll(resp.Body)
	resp.Body.Close()
	if err != nil {
		t.Fatal(err)
	}
	if have, want := string(helloWorldResponse), "{\"hello\":\"world\"}"; have != want {
		t.Errorf("The response is wrong. Have: %s, want: %s.", have, want)
	}
}