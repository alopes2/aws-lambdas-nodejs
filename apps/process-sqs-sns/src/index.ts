import type {
  Context,
  SNSEvent,
  SNSEventRecord,
  SQSEvent,
  SQSRecord,
} from 'aws-lambda';

export const handler = async (
  event: SNSEvent | SQSEvent,
  context: Context
): Promise<void> => {
  console.log('Received event ', event);

  for (let record of event.Records) {
    const sqsRecord = record as SQSRecord;
    if (sqsRecord.eventSource === 'aws:sqs') {
      processSQS(sqsRecord);
      continue;
    }

    // eventSource === 'aws:sns'
    processSNS(record as SNSEventRecord);
  }
};

function processSNS(record: SNSEventRecord) {
  console.log('Processing SNS event record ', record);
}

function processSQS(record: SQSRecord) {
  console.log('Processing SQS record ', record);
}
