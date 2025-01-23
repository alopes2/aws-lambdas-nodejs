import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import type { Context } from 'aws-lambda';

const tableName = 'nodejs-meetup';

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event: any, context: Context) => {
  const id = crypto.randomUUID();

  const command = new PutCommand({
    TableName: tableName,
    Item: {
      ID: id,
      Date: new Date().toISOString(),
    },
  });
  try {
    await docClient.send(command);

    const response = {
      statusCode: 201,
      body: JSON.stringify({ message: 'Created successfully' }),
    };

    return response;
  } catch (e: any) {
    console.log('Error calling PutItem: ', e);

    return {
      statusCode: 500,
      body: JSON.stringify({
        message: e.message,
      }),
    };
  }
};
