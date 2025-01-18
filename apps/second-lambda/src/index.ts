export const handler = async (event: any) => {
  console.log('Received event ', event);

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello from lambda!',
    }),
  };
};
