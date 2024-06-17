-
-
- # 22-2 Sessions with Eric for Braze Proxy
- If you want to check the JWT, use CyberChef "JWT Decode"
-
- With following curl request we can get a access_token for a service account:
  ```
   curl -X POST \
    https://keycloak-dev.global.picnicinternational.com/auth/realms/picnic/protocol/openid-connect/token \
    --data 'grant_type=client_credentials&client_id=braze&client_secret=lPbc107BtKXs34ye0DSxFKz0ZIcSgbN' \
    | jq '.access_token'
   
  ```
-
- Next we can use the token that is returned to do a call to the service:
-
- ```
  curl -v -X POST https://braze-bridge-dev.nl.picnicinternational.com/api/15/braze/proxy/send-push-message -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0YjhQNnRUYWtyNjRjb0pid0o3NkZua1FRcEDSFY3NjV0YzhWbEZROW1rIn0.eyJleHAiOjE3MDg2MTYwMzgsImlhdCI6MTcwODYxNTczOCwianRpIjoiMDI0ZWYyNDEtMzVkNC00Y2RmLTk5MmMtNGYzNGMyMzU1NGNmIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay1kZXYuZ2xvYmFsLnBpY25pY2ludGVybmF0aW9uYWwuY29tL2F1dGgvcmVhbG1zL3BpY25pYyIsImF1ZCI6WyJwcnAiLCJhY2NvdW50Il0sInN1YiI6IjYwMDA4MzIzLTZlNjgtNGRlZS1hZWViLTU1OTkwYmUxZTQwNyIsInR5cCI6IkJlYXJlciIsImF6cCI6ImJyYXplIiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJCUkFaRV9QUk9YWSIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXBpY25pYyJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiYXVkaWVuY2UgZW1haWwgcHJvZmlsZSIsImNsaWVudEhvc3QiOiIxODUuMTMzLjEwOC4xMzEiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInByZWZlcnJlZF91c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1icmF6ZSIsImNsaWVudEFkZHJlc3MiOiIxODUuMTMzLjEwOC4xMzEiLCJjbGllbnRfaWQiOiJicmF6ZSJ9.Uasptu24AIOu-3onkMfDrnT3pzf1mzaniQ7R2pR1_8GcQqYRHXOgrTiV6AeioK7Y1dpPUaOv77F29VSR2NalRKpkTlRe-bVr4BS0_iYwWBtyjKjSF9wRNpGANIwC5a5qjJk9kvRgr1dk0cReM7M5-JvmLjkipKqozS-XyvrUBrIHMjnu3LJzGa_Q8PekEuACxxKfkyXBWeamRCY-_G5U5Aabi9XW_5qtPRvtPWimrJRJlwgiY2_qEYaFPJcMBXK1I-7t1RGAacmUblNC3iANitfkGQ-NjMTKDVrrI76KQOemYeGdU_BsYGA2xPsSkA9oASsA1wm3NT2cIU3cMLq7lA" \
    -H "Content-Type: application/json" --data '{
    "devices": [
      "device ID to add here"
    ],
    "user_id": "",
    "deeplink": "ADD DEEPLINK",
    "title": "TITLE!",
    "body": "ADD A BODY!"
  }'
  
  ```