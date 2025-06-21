const POLICY = `version: STSv1
mode: enforce
mx: in1-smtp.messagingengine.com
mx: in2-smtp.messagingengine.com
max_age: 86400`;

addEventListener("fetch", event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const url = new URL(request.url);
  const headers = { "Content-Type": "text/plain;charset=UTF-8" };

  // Only allow GET requests
  if (request.method !== "GET") {
    return new Response("Method Not Allowed\n", {
      status: 405,
      headers
    });
  }

  // Enforce HTTPS only; no redirects allowed per RFC 8461
  if (url.protocol !== "https:") {
    return new Response("MTA-STS Policy must be accessed over HTTPS\n", {
      status: 400,
      headers
    });
  }

  // Must be exact path - case sensitive per spec
  if (url.pathname !== "/.well-known/mta-sts.txt") {
    return new Response("Not Found\n", {
      status: 404,
      headers
    });
  }

  // Respond with the MTA-STS policy file
  return new Response(POLICY + "\n", {
    status: 200,
    headers
  });
}
