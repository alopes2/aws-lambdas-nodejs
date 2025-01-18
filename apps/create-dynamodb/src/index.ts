import type { Context } from 'aws-lambda';

export const handler = async (event: any, context: Context) => {
  console.log('Received event ', event);

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello from lambda!',
    }),
  };
};
